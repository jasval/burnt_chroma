/*
   Copyright 2023 Jasper Valdivia

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pub mod processor {
    use image::{imageops::FilterType, GenericImageView, ImageError, ImageFormat};
    use std::path::{Path, PathBuf};

    pub enum SqueezeFactor {
        X1_33,
        X1_5,
        X1_75,
        X2,
    }

    impl SqueezeFactor {
        fn value(&self) -> f32 {
            match *self {
                SqueezeFactor::X1_33 => 1.33,
                SqueezeFactor::X1_5 => 1.5,
                SqueezeFactor::X1_75 => 1.75,
                SqueezeFactor::X2 => 2.0,
            }
        }
    }

    pub async fn desqueeze_image(
        image_path: &str,
        output_path: &str,
        image_format: Option<ImageFormat>,
        squeeze_factor: SqueezeFactor,
    ) -> Result<String, ImageError> {
        debug_println!("Identifying file name...");

        let image_path = Path::new(image_path);

        let target_image_format = image_format
            .unwrap_or_else(|| {
                image::ImageFormat::from_path(image_path).unwrap_or(ImageFormat::Png)
            })
            .extensions_str()
            .first()
            .unwrap_or(&"png")
            .to_string();

        let file_name = image_path
            .file_stem()
            .unwrap_or_else(|| image_path.as_os_str())
            .to_str()
            .unwrap_or("")
            .to_string();

        let output_path = Path::new(output_path);

        debug_println!("{}", output_path.to_string_lossy());
        debug_println!("Checking if output directory exists...");
        if !output_path.try_exists()? {
            debug_println!("Creating output directory...");
            std::fs::create_dir(output_path)?;
        }

        debug_println!("Checking if outputh path is directory...");
        let output_file_path: PathBuf;

        if output_path.is_dir() {
            debug_println!("Output path is directory");
            output_file_path = output_path.join(format!("{}.{}", file_name, target_image_format));
            debug_println!("Output path: {}", output_file_path.to_string_lossy());
        } else {
            debug_println!("Output path is not directory. Creating a new directory...");
            output_file_path = output_path.join(format!("/{}.{}", file_name, target_image_format));
            debug_println!("Output path: {}", output_file_path.to_string_lossy());
        }

        debug_println!("Desqueezing {}...", file_name);

        let image = image::open(image_path)?;
        let (width, height) = image.dimensions();

        let mut width = width as f32;
        let mut height = height as f32;

        if width > height {
            width *= squeeze_factor.value();
        } else if height > width {
            height *= squeeze_factor.value();
        } else {
            debug_println!("Do not desqueeze square images");
        }

        let path_ref = output_file_path.as_path();
        debug_println!("{}", path_ref.to_string_lossy());
        let new_image = image.resize_exact(width as u32, height as u32, FilterType::Nearest);
        new_image.save(path_ref)?;
        return Ok(path_ref.to_string_lossy().to_string());
    }
}

#[cfg(test)]
mod processor_tests {
    use crate::processor::processor;
    #[tokio::test]
    async fn should_desqueeze_landscape_image() {
        let result = processor::desqueeze_image(
            "src/tests/squeezedLandscape.jpeg",
            "src/tests/output/",
            None,
            processor::SqueezeFactor::X1_33,
        );

        assert_eq!(result.await.is_ok(), true);
        std::fs::remove_file("src/tests/output/squeezedLandscape.jpg").unwrap_or_else(|error| {
            println!("Error: {}", error);
            return ();
        });
    }

    #[tokio::test]
    async fn should_desqueeze_portrait_image() {
        let result = processor::desqueeze_image(
            "src/tests/squeezedPortrait.jpeg",
            "src/tests/output/",
            None,
            processor::SqueezeFactor::X1_33,
        );
        assert_eq!(result.await.is_ok(), true);
        std::fs::remove_file("src/tests/output/squeezedPortrait.jpg").unwrap_or_else(|error| {
            println!("Error: {}", error);
            return ();
        });
    }
}

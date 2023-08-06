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

mod internal;

use image::{ImageError, ImageFormat};
use internal::desqueeze_image_internal;
pub enum SqueezeFactor {
    X1_33,
    X1_5,
    X1_75,
    X2,
}

impl SqueezeFactor {
    pub fn value(&self) -> f32 {
        match *self {
            SqueezeFactor::X1_33 => 1.33,
            SqueezeFactor::X1_5 => 1.5,
            SqueezeFactor::X1_75 => 1.75,
            SqueezeFactor::X2 => 2.0,
        }
    }

    pub fn from_swift(squeeze_factor: SqueezeFactor) -> SqueezeFactor {
        match squeeze_factor {
            SqueezeFactor::X1_33 => SqueezeFactor::X1_33,
            SqueezeFactor::X1_5 => SqueezeFactor::X1_5,
            SqueezeFactor::X1_75 => SqueezeFactor::X1_75,
            SqueezeFactor::X2 => SqueezeFactor::X2,
        }
    }
}

pub async fn desqueeze_image(
    image_path: &str,
    output_path: &str,
    image_format: Option<ImageFormat>,
    squeeze_factor: SqueezeFactor,
) -> Result<String, ImageError> {
    return desqueeze_image_internal(image_path, output_path, image_format, squeeze_factor).await;
}

#[cfg(test)]
mod processor_tests {
    use super::{desqueeze_image, SqueezeFactor};

    #[tokio::test]
    async fn should_desqueeze_landscape_image() {
        let result = desqueeze_image(
            "src/tests/squeezedLandscape.jpeg",
            "src/tests/output/",
            None,
            SqueezeFactor::X1_33,
        );

        assert_eq!(result.await.is_ok(), true);
        std::fs::remove_file("src/tests/output/squeezedLandscape.jpg").unwrap_or_else(|error| {
            println!("Error: {}", error);
            return ();
        });
    }

    #[tokio::test]
    async fn should_desqueeze_portrait_image() {
        let result = desqueeze_image(
            "src/tests/squeezedPortrait.jpeg",
            "src/tests/output/",
            None,
            SqueezeFactor::X1_33,
        );
        assert_eq!(result.await.is_ok(), true);
        std::fs::remove_file("src/tests/output/squeezedPortrait.jpg").unwrap_or_else(|error| {
            println!("Error: {}", error);
            return ();
        });
    }
}

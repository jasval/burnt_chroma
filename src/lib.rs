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

pub mod processor;
uniffi::include_scaffolding!("lib");

pub mod swift_ffi {
    use crate::processor;
    use image::ImageFormat as CrateImageFormat;

    #[derive(Debug, PartialEq, Eq, Clone, Copy, uniffi::Enum)]
    pub enum ImageFormat {
        Avif,
        Bmp,
        Gif,
        Ico,
        Jpeg,
        Png,
        Pnm,
        Tiff,
        WebP,
        Tga,
        Dds,
        Farbfeld,
        Hdr,
        OpenExr,
        Qoi,
        Heif,
        Heic,
    }

    #[derive(Debug, thiserror::Error, uniffi::Error)]
    pub enum ImageProcessingError {
        #[error("Image format not supported")]
        ImageFormatNotSupported,
        #[error("Image error")]
        ImageError { description: String },
    }

    impl From<ImageFormat> for Option<CrateImageFormat> {
        fn from(image_format: ImageFormat) -> Self {
            match image_format {
                ImageFormat::Avif => Some(CrateImageFormat::Avif),
                ImageFormat::Bmp => Some(CrateImageFormat::Bmp),
                ImageFormat::Gif => Some(CrateImageFormat::Gif),
                ImageFormat::Ico => Some(CrateImageFormat::Ico),
                ImageFormat::Jpeg => Some(CrateImageFormat::Jpeg),
                ImageFormat::Png => Some(CrateImageFormat::Png),
                ImageFormat::Pnm => Some(CrateImageFormat::Pnm),
                ImageFormat::Tiff => Some(CrateImageFormat::Tiff),
                ImageFormat::WebP => Some(CrateImageFormat::WebP),
                ImageFormat::Tga => Some(CrateImageFormat::Tga),
                ImageFormat::Dds => Some(CrateImageFormat::Dds),
                ImageFormat::Farbfeld => Some(CrateImageFormat::Farbfeld),
                ImageFormat::Hdr => Some(CrateImageFormat::Hdr),
                ImageFormat::OpenExr => Some(CrateImageFormat::OpenExr),
                ImageFormat::Qoi => Some(CrateImageFormat::Qoi),
                ImageFormat::Heif | ImageFormat::Heic => None,
            }
        }
    }

    pub fn get_optional_image_format(image_format: ImageFormat) -> Option<CrateImageFormat> {
        image_format.into()
    }

    // #[uniffi::export]
    pub async fn desqueeze_image(
        image_path: String,
        output_path: String,
        image_format: Option<ImageFormat>,
        squeeze_factor: processor::SqueezeFactor,
    ) -> Result<String, ImageProcessingError> {
        let new_image_format: Option<CrateImageFormat>;
        if image_format.is_some() {
            new_image_format = image_format.unwrap().into();
        } else {
            new_image_format = None;
        }
        return processor::desqueeze_image(
            image_path.as_str(),
            output_path.as_str(),
            new_image_format,
            squeeze_factor,
        )
        .await
        .map_err(|error| ImageProcessingError::ImageError {
            description: error.to_string(),
        });
    }

    #[cfg(test)]
    mod swift_ffi_tests {
        use super::{get_optional_image_format, ImageFormat};

        #[test]
        fn should_return_valid_format() {
            assert_ne!(get_optional_image_format(ImageFormat::Avif), None);
        }

        #[test]
        fn should_return_empty() {
            assert_eq!(get_optional_image_format(ImageFormat::Heic), None)
        }
    }
}

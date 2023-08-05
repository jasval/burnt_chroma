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
pub mod swift_ffi {
    use image::ImageFormat;
    use image_objects::proto_image_format::FormatType;
    use image_objects::ProtoImageFormat;

    pub mod image_objects {
        include!(concat!(env!("OUT_DIR"), "/swift_ffi.image_objects.rs"));
    }

    impl From<ProtoImageFormat> for Option<ImageFormat> {
        fn from(proto_image_format: ProtoImageFormat) -> Self {
            match FormatType::from_i32(proto_image_format.kind) {
                Some(FormatType::Avif) => Some(ImageFormat::Avif),
                Some(FormatType::Bmp) => Some(ImageFormat::Bmp),
                Some(FormatType::Gif) => Some(ImageFormat::Gif),
                Some(FormatType::Ico) => Some(ImageFormat::Ico),
                Some(FormatType::Jpeg) => Some(ImageFormat::Jpeg),
                Some(FormatType::Png) => Some(ImageFormat::Png),
                Some(FormatType::Pnm) => Some(ImageFormat::Pnm),
                Some(FormatType::Tiff) => Some(ImageFormat::Tiff),
                Some(FormatType::WebP) => Some(ImageFormat::WebP),
                Some(FormatType::Tga) => Some(ImageFormat::Tga),
                Some(FormatType::Dds) => Some(ImageFormat::Dds),
                Some(FormatType::Farbfeld) => Some(ImageFormat::Farbfeld),
                Some(FormatType::Hdr) => Some(ImageFormat::Hdr),
                Some(FormatType::OpenExr) => Some(ImageFormat::OpenExr),
                Some(FormatType::Qoi) => Some(ImageFormat::Qoi),
                Some(FormatType::Heif) => None,
                Some(FormatType::Heic) => None,
                _ => None,
            }
        }
    }

    pub fn get_optional_image_format(value: i32) -> Option<ImageFormat> {
        let mut image_format = ProtoImageFormat::default();
        image_format.kind = value;
        return image_format.into();
    }
}

// Test to implement a function that adds two numbers
fn add(a: u32, b: u32) -> u32 {
    a + b
}

#[cfg(test)]
mod swift_ffi_tests {
    use super::swift_ffi::get_optional_image_format;

    #[test]
    fn should_return_valid_format() {
        assert_ne!(get_optional_image_format(3), None);
    }

    #[test]
    fn should_return_empty() {
        assert_eq!(get_optional_image_format(100), None);
    }
}

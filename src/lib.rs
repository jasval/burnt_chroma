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
use image::ImageFormat as ImagePackageImageFormat;
use processor::processor::desqueeze_image;
use swift_ffi::ImageFormat;

impl ImageFormat {
    pub fn new(image_format: ImagePackageImageFormat) -> ImageFormat {
        match image_format {
            ImagePackageImageFormat::Avif => ImageFormat::Avif,
            ImagePackageImageFormat::Bmp => ImageFormat::Bmp,
            ImagePackageImageFormat::Gif => ImageFormat::Gif,
            ImagePackageImageFormat::Ico => ImageFormat::Ico,
            ImagePackageImageFormat::Jpeg => ImageFormat::Jpeg,
            ImagePackageImageFormat::Png => ImageFormat::Png,
            ImagePackageImageFormat::Pnm => ImageFormat::Pnm,
            ImagePackageImageFormat::Tiff => ImageFormat::Tiff,
            ImagePackageImageFormat::WebP => ImageFormat::WebP,
            ImagePackageImageFormat::Tga => ImageFormat::Tga,
            ImagePackageImageFormat::Dds => ImageFormat::Dds,
            ImagePackageImageFormat::Farbfeld => ImageFormat::Farbfeld,
            ImagePackageImageFormat::Hdr => ImageFormat::Hdr,
            ImagePackageImageFormat::OpenExr => ImageFormat::OpenExr,
            ImagePackageImageFormat::Qoi => ImageFormat::Qoi,
            _ => ImageFormat::NotSupported,
        }
    }

    fn to_image_format(&self) -> Option<ImagePackageImageFormat> {
        match &self {
            Self::Avif => Some(ImagePackageImageFormat::Avif),
            Self::Bmp => Some(ImagePackageImageFormat::Bmp),
            Self::Gif => Some(ImagePackageImageFormat::Gif),
            Self::Ico => Some(ImagePackageImageFormat::Ico),
            Self::Jpeg => Some(ImagePackageImageFormat::Jpeg),
            Self::Png => Some(ImagePackageImageFormat::Png),
            Self::Pnm => Some(ImagePackageImageFormat::Pnm),
            Self::Tiff => Some(ImagePackageImageFormat::Tiff),
            Self::WebP => Some(ImagePackageImageFormat::WebP),
            Self::Tga => Some(ImagePackageImageFormat::Tga),
            Self::Dds => Some(ImagePackageImageFormat::Dds),
            Self::Farbfeld => Some(ImagePackageImageFormat::Farbfeld),
            Self::Hdr => Some(ImagePackageImageFormat::Hdr),
            Self::OpenExr => Some(ImagePackageImageFormat::OpenExr),
            Self::Qoi => Some(ImagePackageImageFormat::Qoi),
            _ => None,
        }
    }
}

// We can use the `swift_bridge` macro to generate the Swift FFI for us.
// Then at build time the `swift_bridge-build` crate is used to generate
// the corresponding Swift and C FFI glue code.
#[swift_bridge::bridge]
mod swift_ffi {

    enum ImageSqueezeFactor {
        X1_33,
        X1_5,
        X1_75,
        X2,
    }

    pub enum ImageFormat {
        Png,
        Jpeg,
        Gif,
        WebP,
        Pnm,
        Tiff,
        Tga,
        Dds,
        Bmp,
        Ico,
        Hdr,
        OpenExr,
        Farbfeld,
        Avif,
        Qoi,
        Heic,
        NotSupported,
    }

    extern "Rust" {
        async fn desqueeze_image(
            image_path: &str,
            output_path: &str,
            image_format: Option<ImageFormat>,
            squeeze_factor: ImageSqueezeFactor,
        ) -> Result<String, String>;
    }
}

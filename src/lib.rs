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

#[cfg(debug_assertions)]
macro_rules! debug_println {
    ($($args:tt)*) => { println!($($args)*) };
}

pub mod processor;
use image::{ImageError, ImageFormat};
use processor::processor::{desqueeze_image, SqueezeFactor};
use swift_bridge;

// We can use the `swift_bridge` macro to generate the Swift FFI for us.
// Then at build time the `swift_bridge-build` crate is used to generate
// the corresponding Swift and C FFI glue code.
#[swift_bridge::bridge]
mod swift_ffi {

    extern "Rust" {
        type SqueezeFactor;
        type ImageError;
        type ImageFormat;

        async fn desqueeze_image(
            image_path: &str,
            output_path: &str,
            image_format: Option<ImageFormat>,
            squeeze_factor: SqueezeFactor,
        ) -> Result<String, ImageError>;
    }
}

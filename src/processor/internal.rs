// Module: processor/internal.rs
use super::SqueezeFactor;
use image::{imageops::FilterType, GenericImageView, ImageError, ImageFormat};
use std::path::{Path, PathBuf};

pub(crate) async fn desqueeze_image_internal(
    image_path: &str,
    output_path: &str,
    image_format: Option<ImageFormat>,
    squeeze_factor: SqueezeFactor,
) -> Result<String, ImageError> {
    let image_path = Path::new(image_path);

    let target_image_format = image_format
        .unwrap_or_else(|| ImageFormat::from_path(image_path).unwrap_or(ImageFormat::Png))
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

    if !output_path.try_exists()? {
        std::fs::create_dir(output_path)?;
    }

    let output_file_path: PathBuf;

    if output_path.is_dir() {
        output_file_path = output_path.join(format!("{}.{}", file_name, target_image_format));
    } else {
        output_file_path = output_path.join(format!("/{}.{}", file_name, target_image_format));
    }

    let image = image::open(image_path)?;
    let (width, height) = image.dimensions();

    let mut width = width as f32;
    let mut height = height as f32;

    if width > height {
        width *= squeeze_factor.value();
    } else if height > width {
        height *= squeeze_factor.value();
    }

    let path_ref = output_file_path.as_path();
    let new_image = image.resize_exact(width as u32, height as u32, FilterType::Nearest);
    new_image.save(path_ref)?;
    return Ok(path_ref.to_string_lossy().to_string());
}

import numpy as np
from PIL import Image

def HWC3(x):
    assert x.dtype == np.uint8
    if x.ndim == 2:
        x = x[:, :, None]
    assert x.ndim == 3
    H, W, C = x.shape
    assert C == 1 or C == 3 or C == 4
    if C == 3:
        return x
    if C == 1:
        return np.concatenate([x, x, x], axis=2)
    if C == 4:
        color = x[:, :, 0:3].astype(np.float32)
        alpha = x[:, :, 3:4].astype(np.float32) / 255.0
        y = color * alpha + 255.0 * (1.0 - alpha)
        y = y.clip(0, 255).astype(np.uint8)
        return y

def _prepare_hed_image(controlnet_img, hed_processor):
    if not isinstance(controlnet_img, np.ndarray):
        controlnet_img = np.array(controlnet_img, dtype=np.uint8)
    assert controlnet_img.dtype == np.uint8
    if controlnet_img.ndim == 2:
        controlnet_img = controlnet_img[:, :, None]
    assert controlnet_img.ndim == 3
    H, W, C = controlnet_img.shape
    assert C == 1 or C == 3
    if C == 3:
        pass
    if C == 1:
        controlnet_img = np.concatenate([controlnet_img, controlnet_img, controlnet_img], axis=2)
    controlnet_img = controlnet_img[:, :, ::-1].copy()

    image_hed = controlnet_img.astype(float)
    image_hed = image_hed / 255.0
    image_hed = image_hed.transpose((2,0,1)).reshape(1, 3, 512, 512)
    image_hed = [image_hed]
    edge = hed_processor(image_hed)
    edge = (edge[0] * 255.0).clip(0, 255).astype(np.uint8)
    detected_map = edge[0]
    detected_map = HWC3(detected_map)

    detected_map = Image.fromarray(detected_map)

    detected_map = detected_map.convert("RGB")
    # pil to numpy
    detected_map = np.array(detected_map).astype(np.float32) / 255.0
    detected_map = [detected_map]
    detected_map = np.stack(detected_map, axis = 0)

    # (batch, channel, height, width)
    detected_map = detected_map.transpose(0, 3, 1, 2)

    detected_map_copy = np.copy(detected_map)
    detected_map = np.concatenate((detected_map,detected_map_copy), axis = 0)
    return detected_map
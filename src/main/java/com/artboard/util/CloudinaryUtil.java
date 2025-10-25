package com.artboard.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.IOException;
import java.util.Map;

public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "donqkiapi",
                "api_key", "344818727728573",
                "api_secret", "AymNcy2tkFLpa1GxEr6GFPaPB8I"
        ));
    }
    public static String uploadImage(byte[] imageData, String fileName) throws IOException {
        Map<?, ?> uploadResult = cloudinary.uploader().upload(imageData,
                ObjectUtils.asMap(
                        "public_id", "artboard/" + System.currentTimeMillis() + "_" + fileName,
                        "folder", "artboard/pins"
                ));

        return (String) uploadResult.get("secure_url");
    }

    public static void deleteImage(String imageUrl) throws IOException {
        String publicId = extractPublicIdFromUrl(imageUrl);
        if (publicId != null) {
            cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        }
    }
    private static String extractPublicIdFromUrl(String url) {
        try {
            String[] parts = url.split("/upload/");
            if (parts.length > 1) {
                String path = parts[1];
                if (path.startsWith("v")) {
                    path = path.substring(path.indexOf('/') + 1);
                }
                int lastDot = path.lastIndexOf('.');
                if (lastDot != -1) {
                    path = path.substring(0, lastDot);
                }
                return path;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

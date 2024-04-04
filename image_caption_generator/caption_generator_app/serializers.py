from rest_framework import serializers
from .models import UploadedImage

class UploadedImageSerializer(serializers.ModelSerializer):
    
    image_url = serializers.SerializerMethodField()
    attention_image_url = serializers.SerializerMethodField()

    class Meta:
        model = UploadedImage
        fields = ('caption', 'image_url', 'attention_image_url', 'uploaded_at')

    def get_image_url(self, obj):
        return self._get_image_url(obj.image, 'uploaded_images')

    def get_attention_image_url(self, obj):
        return self._get_image_url(obj.attention_image, 'uploaded_images_with_attention')

    def _get_image_url(self, image_field, upload_folder):
        image_url = f'{upload_folder}/{image_field.name}'
        return self.context['request'].build_absolute_uri(f'/media/{image_url}')

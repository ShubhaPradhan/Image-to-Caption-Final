from rest_framework import serializers
from .models import UploadedImage

class UploadedImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = UploadedImage
        fields = ('image', 'uploaded_at', 'caption', 'attention_image')

        def get_image_url(self, obj):
            return self.context['request'].build_absolute_uri(obj.image.url)
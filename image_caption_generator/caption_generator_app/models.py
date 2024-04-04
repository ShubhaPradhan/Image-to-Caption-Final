from django.db import models

class UploadedImage(models.Model):
    image = models.ImageField(upload_to='image_caption_generator_model/uploaded_images/')
    uploaded_at = models.DateTimeField(auto_now_add=True)
    caption = models.TextField(blank=True, null=True)
    attention_image = models.ImageField(upload_to='image_caption_generator_model/attention_images/', blank=True, null=True)

    def __str__(self):
        return self.image.name
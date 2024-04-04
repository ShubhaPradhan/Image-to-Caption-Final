from django.contrib import admin
from .models import UploadedImage

class UploadedImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'image', 'uploaded_at', 'caption', 'attention_image')  # Fields to display in the admin list view
    list_filter = ('uploaded_at',)  # Filters available in the right sidebar
    search_fields = ('caption',)  # Add a search bar to search by caption

admin.site.register(UploadedImage, UploadedImageAdmin)
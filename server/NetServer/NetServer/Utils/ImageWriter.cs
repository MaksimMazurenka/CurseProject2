using Microsoft.AspNetCore.Http;
using NetServer.Interface;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetServer.Utils
{
    public class ImageWriter : IImageWriter
    {
        public async Task<string> UploadImage(IFormFile file)
        {
            if (CheckIfImageFile(file))
            {
                return await WriteFile(file);
            }
            return "inwalid image file";
        }

        private async Task<string> WriteFile(IFormFile file)
        {
            string fileName;
            try
            {
                var extension = new StringBuilder(".").Append(file.FileName.Split(".")[file.FileName.Split('.').Length - 1]);
                fileName = new StringBuilder(Guid.NewGuid().ToString()).Append(extension).ToString();
                string path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot\\images", fileName);
                using (var bits = new FileStream(path, FileMode.Create))
                    await file.CopyToAsync(bits);
            }catch(Exception e)
            {
                return e.Message;
            }
            return fileName;
        }

        private bool CheckIfImageFile(IFormFile file)
        {
            byte[] fileBytes;
            using(var ms=new MemoryStream())
            {
                file.CopyTo(ms);
                fileBytes = ms.ToArray();
            }
            return WriteHelper.GetImageFormat(fileBytes) != WriteHelper.ImageFormat.unknown;
        }
    }
}

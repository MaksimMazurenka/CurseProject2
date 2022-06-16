using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NetServer.Handler;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UploadController : ControllerBase
    {
        private readonly IImageHandler _imageHandler;
        public UploadController(IImageHandler imageHandler)
        {
            _imageHandler = imageHandler;
        }
        [HttpPost]
        public async Task<IActionResult> UploadImage(IFormFile file)
        {
            return await _imageHandler.UploadImage(file);
        }
    }
}

﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Sabio.Services.Interfaces;
using Sabio.Services;
using Microsoft.Extensions.Logging;
using Sabio.Web.Controllers;
using Sabio.Models.Requests.Files;
using Sabio.Models;
using Sabio.Web.Models.Responses;
using System.Collections.Generic;
using System;
using Sabio.Models.Domain.Files;
using Microsoft.Build.Utilities;
using NuGet.ProjectModel;
using System.Threading.Tasks;
using System.Linq;
using System.IO;
using File = Sabio.Models.Domain.Files.File;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.CodeAnalysis;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.ComponentModel;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/files")]
    [ApiController]
    public class FileApiController : BaseApiController
    {
        private IFileService _service = null;
        private IAuthenticationService<int> _authService = null;

        public FileApiController(IFileService fileService, ILogger<FileApiController> logger, IAuthenticationService<int> authService)
        : base(logger)
        {
            _service = fileService;
            _authService = authService;
        }

        [HttpPost]
        public async Task<ActionResult<ItemResponse<List<File>>>> Add(IFormFile[] file)
        {
            int code = 201;
            BaseResponse response;
            int userId = 0;
            List<BaseFile> files = new List<BaseFile>();

            try
            {
                userId = _authService.GetCurrentUserId();
                for (int i = 0; i < file.Length; i++)
                {
                    if (file[i].Length > 8388608)
                    {
                        throw new FileFormatException("File size over 100m b limit");
                    }
                    else {
                        //string fileName = $"{System.IO.Path.GetRandomFileName()}_-_{file[i].FileName}"  ;
                        string fileName = $"userfile_{userId}_{System.IO.Path.GetRandomFileName()}_-_{file[i].FileName}";
                       
                        FileAddRequest fileModel = new FileAddRequest();
                        fileModel.Name = fileName;
                        fileModel.FileTypeId = _service.GetFileTypeByExt(file[i].FileName);
                        fileModel.Url = await _service.UploadFile(file[i], fileName);
                        fileModel.CreatedBy = userId;

                        BaseFile fileResponse = _service.Add(fileModel,userId);
                        files.Add(fileResponse);

                    }
                     
                }

                response = new ItemResponse<List<BaseFile>> { Item = files };
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpGet]
        public ActionResult<ItemResponse<Paged<File>>> GetPaginated(int pageIndex, int pageSize, bool isDeleted)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<File> page = _service.GetAll(pageIndex, pageSize, isDeleted);
                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("paged list of files not found");
                }
                else
                {
                    response = new ItemResponse<Paged<File>> { Item = page };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());

            }
            return (StatusCode(code, response));
        }

        [HttpGet("createdby")]
        public ActionResult<ItemsResponse<Paged<File>>> GetPaginatedByCreated(int pageIndex, int pageSize, int createdId)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<File> page = _service.GetByCreatedBy(pageIndex, pageSize, createdId);
                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("search for paged list of files not found");
                }
                else
                {
                    response = new ItemResponse<Paged<File>> { Item = page };
                }
            }
            catch (Exception ex)
            {

                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }
            return (StatusCode(code, response));
        }
        
        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Delete(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.DeleteById(id);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpGet("search")]
        public ActionResult<ItemsResponse<Paged<File>>> Search(int pageIndex, int pageSize,bool isDeleted, string query)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<File> paged = _service.Search(pageIndex, pageSize,isDeleted, query);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<File>>() { Item = paged };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message.ToString());
            }
            return StatusCode(code, response);

        }

    }
}

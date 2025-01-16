using Microsoft.EntityFrameworkCore;
using final.Models;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers()
 .AddJsonOptions(options =>
        {
            options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
        });

var connectionString = builder.Configuration.GetConnectionString("ECommerce")
        ?? throw new InvalidOperationException("Connection string not found.");

builder.Services.AddDbContext<EcommerceContext>(opt =>
    opt.UseSqlServer(connectionString));

builder.Services.AddDbContext<UserIdentityContext>(opt =>
opt.UseSqlServer(connectionString));
builder.Services.AddAuthorization();
builder.Services.AddIdentityApiEndpoints<IdentityUser>()
    .AddEntityFrameworkStores<UserIdentityContext>();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGroup("/account").MapIdentityApi<IdentityUser>();

app.UseHttpsRedirection();

app.UseCors(x => x.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.UseAuthorization();

app.MapControllers();

app.Run();


/* 

dotnet ef dbcontext scaffold "server=localhost;database=ECommerce;UID=ECommerce123;PWD=ECommerce_123;Trusted_Connection=False;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -o Models

dotnet aspnet-codegenerator controller -name ProductsController -async -api -m Product -dc EcommerceContext -outDir Controllers

dotnet aspnet-codegenerator controller -name OrderProductController -async -api -m OrderProduct -dc EcommerceContext -outDir Controllers

dotnet aspnet-codegenerator controller -name CategoryController -async -api -m Category -dc EcommerceContext -outDir Controllers

dotnet aspnet-codegenerator controller -name CustomerNoLoginController -async -api -m CustomerNoLogin -dc EcommerceContext -outDir Controllers

dotnet aspnet-codegenerator controller -name OrderNoLoginController -async -api -m OrderNoLogin -dc EcommerceContext -outDir Controllers

dotnet aspnet-codegenerator controller -name OrderNoLoginProductController -async -api -m OrderNoLoginProduct -dc EcommerceContext -outDir Controllers

dotnet ef migrations add InitialUserIdentity  --context UserIdentityContext

dotnet ef database update --context UserIdentityContext 

 */


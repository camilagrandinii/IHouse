using ihouse.Database;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<UserContext>(
		o => o.UseNpgsql(builder.Configuration.GetConnectionString("UserDB"))
	);
			
var app = builder.Build();

app.Use(async (context, nextMiddleware) =>
        {
          Console.WriteLine("2");

          context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
          context.Response.Headers.Add("Access-Control-Allow-Methods", "*");
          context.Response.Headers.Add("Access-Control-Allow-Headers", "*");
          context.Response.Headers.Add("Access-Control-Max-Age", "86400");

          await nextMiddleware();
        });

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment()) {
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
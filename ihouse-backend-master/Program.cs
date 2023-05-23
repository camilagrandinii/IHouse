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

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment()) {
	app.UseSwagger();
	app.UseSwaggerUI();
}

app.UseCors(options =>
 			options.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin()
			);

app.UseHttpsRedirection();

app.UseAuthorization();


app.MapControllers();

app.Run();
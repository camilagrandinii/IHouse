using ihouse.Database;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<UserContext>(
		o => o.UseSqlServer("Server=tcp:ihouse-servidor.database.windows.net,1433;Initial Catalog=IHouse;Persist Security Info=False;User ID=1313525@sga.pucminas.br;Password=Senha2002;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Authentication=\"Active Directory Password\";")
	);
			
var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();

app.UseCors(options =>
 			options.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin()
			);

app.UseHttpsRedirection();

app.UseAuthorization();


app.MapControllers();

app.Run();
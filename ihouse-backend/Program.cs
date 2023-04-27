using ihouse.Database;
using ihouse.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<DbUser>(opt => opt.UseInMemoryDatabase("User"));
var app = builder.Build();
bool janelaNeedFechamento = false;

app.MapGet("/user", async (DbUser db) => {
	return await db.User.ToListAsync();
});

app.MapGet("/user/{username}", async (string username, DbUser db) => {
	return await db.User.Where((user) => user.Username == username).SingleAsync()
		is User user
		? Results.Ok(user)
		: Results.NotFound();
});

app.MapPost("/user", async (User user, DbUser db) => {
	db.User.Add(user);
	await db.SaveChangesAsync();

	return Results.Created($"/todoitems/{user.Id}", user);
});

app.MapDelete("/user/{id}", async (int id, DbUser db) => {
	if (await db.User.FindAsync(id) is User user) {
		db.User.Remove(user);
		await db.SaveChangesAsync();
		return Results.Ok(user);
	}
	return Results.NotFound();
});

app.MapPut("/user/{id}", async (int id, User inputUser, DbUser db) => {
	var user = await db.User.FindAsync(id);

	if (user is null) return Results.NotFound();

	user.Username = inputUser.Username;
	user.Email = inputUser.Email;
	user.Password = inputUser.Password;

	await db.SaveChangesAsync();

	return Results.NoContent();
});

app.MapPost("/sensor/", (Janela inputJanela) => {

	if (inputJanela.Sensor > 0.2f && inputJanela.IsAberta) {
		janelaNeedFechamento = true;
	} else {
		janelaNeedFechamento = false;
	}

	return Results.Ok(janelaNeedFechamento);
});

app.MapGet("/sensor/", () => {
	return Results.Ok(janelaNeedFechamento);
});

app.Run();

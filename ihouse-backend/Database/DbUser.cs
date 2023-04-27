using ihouse.Models;
using Microsoft.EntityFrameworkCore;

namespace ihouse.Database {
	public class DbUser : DbContext {
		public DbUser(DbContextOptions<DbUser> options)
		: base(options) { }

		public DbSet<User> User => Set<User>();
	}
}

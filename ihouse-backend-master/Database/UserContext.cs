using ihouse.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace ihouse.Database {
	public class UserContext : DbContext {
		public UserContext(DbContextOptions<UserContext> options)
		: base(options) { }

		public DbSet<User> Users { get; set; }
	}
}

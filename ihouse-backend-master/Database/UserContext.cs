﻿using ihouse.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace ihouse.Database {
	public class UserContext : DbContext {
		public UserContext(DbContextOptions<UserContext> options)
		: base(options) { }

		public DbSet<User> User { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(entity =>
            { 
                entity.HasKey(entity => entity.Id);
                entity.Property(entity => entity.Id).ValueGeneratedOnAdd().IsRequired();
            });
        }
    }
}

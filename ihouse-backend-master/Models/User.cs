using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Newtonsoft.Json;

namespace ihouse.Models {
	[Table("User")]
	public class User {
		[Key]
		public int Id { get; set; }
		
		public string Username { get; set; }

		public string Email { get; set; }

		public string Password { get; set; }
	}
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ihouse_backend.Migrations
{
    /// <inheritdoc />
    public partial class AgeRemoved : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Age",
                table: "User");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Age",
                table: "User",
                type: "text",
                nullable: false,
                defaultValue: "");
        }
    }
}


using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Cors;
using ihouse.Models;

namespace ihouse_backend.Controllers {

	[Route("api/[controller]")]
	[ApiController]
	[EnableCors]
	public class SensorController : ControllerBase {
		private static List<Janela> janelas;

		// GET: api/Sensor
		[HttpGet]
		public IEnumerable<Janela> GetSensor() {
			return janelas.ToList();
		}

		// POST: api/Sensor
		[HttpPost]
		public void PostSensor(Janela[] janela) {
			janelas = new List<Janela>();
			foreach (Janela j in janela) {
				janelas.Add(j);
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ihouse.Database;
using ihouse.Models;
using System.Collections;

namespace ihouse_backend.Controllers {

	[Route("api/[controller]")]
	[ApiController]
	public class SensorController : ControllerBase {
		private static List<Janela> janelas;

		// GET: api/Sensor
		[HttpGet]
		public IEnumerable<Janela> GetSensor() {
			return janelas.ToList();
		}

		// POST: api/Sensor
		[HttpPost]
		public object PostSensor(Janela[] janela) {
			janelas = new List<Janela>();
			foreach (Janela j in janela) {
				if (j.IsAberta && j.Sensor > 0.2f) {
					janelas.Add(j);
				}
			}
			return Results.Ok;
		}
	}
}

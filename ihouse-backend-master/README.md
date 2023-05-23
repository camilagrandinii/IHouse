# Projeto de Backend do IHouse

## Endpoints

### Sensor
<details>
	<summary>GET - /api/Sensor</summary>
	<br>
	Retorna um JSON contendo as janelas que necessitam de serem fechadas.
	<br><br>
	<pre>
	[ 
	   {
	      "sensor": 0.8,
	      "isAberta": true,
	      "local": "quarto"
	   }
	]
	</pre>
</details>

<details>
	<summary>POST - /api/Sensor</summary>
	<br>
	Recebe uma lista de janelas em JSON.
	<br><br>
	<pre>
	[ 
	   {
	      "sensor": 0.8,
	      "isAberta": true,
	      "local": "quarto"
	   },
	   {
	      "sensor": 0.2,
	      "isAberta": false,
	      "local": "cozinha"
	   }
	]
	</pre>
</details>

### User

<details>
	<summary>GET - /api/Users</summary>
	<br>
	Retorna um JSON contendo todos os usuários do banco de dados.
</details>

<details>
	<summary>GET - /api/User/{id}</summary>
	<br>
	Retorna um JSON contendo o usuário que contém o ID inserido.
</details>

<details>
	<summary>POST - /api/Users</summary>
	<br>
	Recebe um JSON contendo as informações do usuário para ser inserido ao banco de dados.
</details>

<details>
	<summary>PUT - /api/Users/{id}</summary>
	<br>
	Recebe um JSON contendo as novas informações do usuário para ser atualizado no banco de dados.
</details>

<details>
	<summary>DELETE - /api/Users/{id}</summary>
	<br>
	Deleta o usuário do ID informado.
</details>

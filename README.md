# 💸 CloverWallet

Una aplicacion de billetera vitrtual la cual permite transacciones y depositos monetarios utilizando cuentas registradas en la base de datos por ahora localmente. 

## Funciones
- Log in
- Sign in
- Transferir entre cuentas via cvu
- Depositar
- Ver saldo

## 🛠️ Tecnologías utilizadas

### Backend y Frameworks
    Ruby (3.4.3)
    Sinatra (4.1)
    ActiveRecord (ORM)
    SQLite3 (base de datos)
    bcrypt (hash de contraseñas) 
### Frontend
    HTML5 (vistas ERB)
    CSS3 (estilos personalizados)
    JavaScript (animaciones y lógica visual)
    SVG (logo y assets gráficos)
### Testing
    RSpec
    Rack-Test
    DevOps y Herramientas
    Docker
    Rake (tareas de base de datos)
    Bundler (gestión de gemas)
### Otros
    YAML (configuración de base de datos)
    Puma (servidor web)
    Rackup (servidor de desarrollo)
    Figma
    StarUML

## 🔐 Seguridad
- Hash de contraseñas
- Gestión de sesiones segura
- Protección de rutas
- Prevención de acceso a login/signup estando autenticado
- Validaciones de datos en modelos
- Manejo de errores y mensajes: Los mensajes de error no revelan información sensible y son amigables para el usuario.
- Archivos estáticos protegidos: Solo los archivos dentro de la carpeta public son accesibles desde el navegador.
- Actualizaciones y dependencias:Uso de versiones actualizadas de gemas y dependencias para evitar vulnerabilidades conocidas.

## 🐳Paso a paso para ejecutar CloverWallet usando Docker🐳
Cloná el repositorio:
git clone https://github.com/tu-usuario/cloverwallet.git
cd cloverwallet

Levantá la app con Docker Compose:
docker compose up --build

Accedé desde el navegador:
Ir a: http://localhost:8000

Inicializá la base de datos:
Si usás SQLite y no tenés migraciones aún:
docker compose exec app rake db:migrate
docker compose exec app rake db:seed  

## 👥Integrantes
- Amadeo Mai
- Juan Bonatto
- Agustin Moyano
- Joaquin Puebla
- Agustin Becerra

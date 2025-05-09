# Funcionalidades de la Billetera Digital

## 1. Registro e inicio de sesión

**Historia de usuario:**  
Como nuevo usuario, quiero registrarme con mi correo electrónico y una contraseña, para poder crear una cuenta y empezar a usar la billetera.

**Criterios de aceptación:**

- El usuario puede ingresar un correo válido y una contraseña.  
- Se muestra un mensaje de error si el correo ya está registrado.  
- La contraseña debe cumplir requisitos mínimos (ej: al menos 6 caracteres).  
- Luego del registro exitoso, el usuario es redirigido a la pantalla principal.  
- El usuario puede iniciar sesión posteriormente con las mismas credenciales.  
- Si los datos son incorrectos al iniciar sesión, se muestra un mensaje de error.  

---

## 2. Ver saldo disponible

**Historia de usuario:**  
Como usuario autenticado, quiero ver mi saldo actual en la pantalla principal, para saber cuánto dinero tengo disponible.

**Criterios de aceptación:**

- El saldo se muestra claramente luego de iniciar sesión.  
- El saldo se actualiza automáticamente después de una transferencia o recepción de dinero.  
- Si el usuario no ha recibido ni enviado dinero, el saldo es $0.00.  
- El saldo es visible en un lugar destacado de la pantalla principal.  

---

## 3. Transferir dinero a otro usuario

**Historia de usuario:**  
Como usuario, quiero poder transferir dinero a otro usuario de la billetera, para enviarle fondos de forma rápida y segura.

**Criterios de aceptación:**

- El usuario puede ingresar el cvu o alias del destinatario.  
- El usuario puede escribir el monto a transferir.  
- Se valida que el usuario tenga suficiente saldo.  
- Se muestra un mensaje de confirmación antes de realizar la transferencia.  
- Al confirmar, el saldo del remitente se reduce y el destinatario recibe el dinero.  
- Se muestra un mensaje de éxito o error según el resultado.  

---

## 4. Recibir dinero de otros usuarios

**Historia de usuario:**  
Como usuario, quiero poder ver cuando otro usuario me envíe dinero, para estar informado de los ingresos en mi cuenta.

**Criterios de aceptación:**

- El saldo del usuario aumenta tras recibir dinero.  
- La información del remitente y el monto recibido están visibles.  

---

## 5. Historial de transacciones

**Historia de usuario:**  
Como usuario, quiero acceder a un historial de todas mis transacciones, para poder llevar un control de mis movimientos financieros.

**Criterios de aceptación:**

- El historial muestra la fecha, el tipo de transacción (enviado/recibido), el monto y el contacto involucrado.  
- Las transacciones están ordenadas cronológicamente (más recientes primero).  
- El historial incluye tanto envíos como recepciones de dinero.  
- El usuario puede acceder al historial desde el menú o la pantalla principal.  

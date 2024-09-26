Prueba Técnica para Nectia
Descripción del Proyecto

El proyecto consta de las 3 partes fundamentales para un proyecto base.

1.- Frontend

    El proyecto ha sido desarrollado con el framework de Flutter el cual fue creado con las siguientes caracteristicas
        -Channel stable, 3.19.6
        -Android SDK version 34.0.0
    Para la creacion del APK debe primero clonar el repositorio con 

    ```
    git clone https://github.com/ChristianGodoyInformatico/Prueba-Tecnica-Nectia.git
    ```

    dirigirse al directorio del proyecto
    ```
    cd front_nectia
    ```

    ingresar desde una consola de comandos:
    ```
    flutter build apk --release
    ```

2.- Backend

    El Backend ha sido desarrollado con el framework de NestJS, dicho desarrollo se encuentro desplegado en la nube bajo el servicio de EC2
    de la plataforma AWS, esta app ya se encuentra conectada a una BD la cual se describira a continuacion.

1.- BD

    La BD se encuentra desplegada en un servicio RDS en la plataform de AWS.
    La BD es de tipo Postgres en su version 15


Para el inicio de sesion se encuentran creados dos usuarios en la BD, estos son los siguientes:

```
    {
        username: 'Test One',
        password: 'Abc123',
        email: 'test1@google.com'
    },
    {
        username: 'Test Two',
        email: 'test2@google.com',
        password: 'Abc123'
    }
```
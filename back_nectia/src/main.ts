import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger, ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const logger = new Logger('Bootstrap');
  app.setGlobalPrefix('api');

  // Usar ValidationPipe globalmente con opciones personalizadas
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true, // Elimina propiedades no especificadas en el DTO
    forbidNonWhitelisted: true, // Lanzará un error si se envían propiedades no permitidas
    transform: true, // Transforma automáticamente los tipos de datos
    errorHttpStatusCode: 422, // Cambia el código de estado para errores de validación
  }));

  await app.listen(process.env.PORT);
  logger.log(`App running on port ${process.env.PORT}`);
}
bootstrap();

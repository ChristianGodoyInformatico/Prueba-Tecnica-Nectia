import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { ConfigService } from '@nestjs/config';
import { DataSourceOptions } from 'typeorm';

export const typeOrmModule = (configService: ConfigService): DataSourceOptions => {
    const dbPassword = configService.get<string>('DB_PASSWORD');
    console.log('DB_HOST:', configService.get<string>('DB_HOST'));
    console.log('DB_PORT:', configService.get<number>('DB_PORT'));
    console.log('DB_USERNAME:', configService.get<string>('DB_USERNAME'));
    console.log('DB_PASSWORD:', dbPassword);
    console.log('DB_NAME:', configService.get<string>('DB_NAME'));
  
    return {
      type: 'postgres',
      host: configService.get<string>('DB_HOST'),
      port: configService.get<number>('DB_PORT'),
      username: configService.get<string>('DB_USERNAME'),
      password: dbPassword, // Aquí verificamos la contraseña
      database: configService.get<string>('DB_NAME'),
      entities: [__dirname + '/../**/*.entity{.ts,.js}'],
      synchronize: true, // do not set it true in production application
    };
  };

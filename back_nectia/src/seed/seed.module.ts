import { Module } from '@nestjs/common';
import { SeedService } from './seed.service';
import { SeedController } from './seed.controller';
import { VehiclesModule } from 'src/modules/vehicles/vehicles.module';
import { AuthModule } from 'src/modules/auth/auth.module';
import { UsersModule } from 'src/modules/users/users.module';

@Module({
  imports: [
    VehiclesModule,
    UsersModule,
    AuthModule
  ],
  controllers: [SeedController],
  providers: [SeedService],
})
export class SeedModule {}

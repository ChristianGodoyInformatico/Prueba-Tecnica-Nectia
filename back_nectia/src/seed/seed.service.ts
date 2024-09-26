import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from 'src/modules/users/entities/user.entity';
import { initialData } from './data/seed-data';
import { Vehicle } from 'src/modules/vehicles/entities/vehicle.entity';
import { UsersService } from 'src/modules/users/users.service';


@Injectable()
export class SeedService {

    constructor(
        private readonly usersService: UsersService,
        // @InjectRepository(User)
        // private readonly userRepository: Repository<User>,

        @InjectRepository(Vehicle)
        private readonly vehicleRepository: Repository<Vehicle>,
    ) { }

    async runSeed() {

        await this.deleteTables();
        await this.insertUsers();
        await this.insertVehicles();

        return 'This action run seed';
    }

    private async deleteTables() {
        this.usersService.deleteAllUsers();

        const queryBuilderVehicle = this.vehicleRepository.createQueryBuilder();
        await queryBuilderVehicle
            .delete()
            .where({})
            .execute()
    }

    private async insertUsers() {
        // const seedUsers = initialData.users;

        // const users: User[] = [];

        // seedUsers.forEach(user => {
        //     user.password = bcrypt.hashSync(user.password, 10);
        //     users.push(this.userRepository.create(user))
        // });

        // await this.userRepository.save(seedUsers);
        // this.productsService.deleteAllProducts();

    const users = initialData.users;

    const insertPromises = [];

    users.forEach(user => {
        insertPromises.push(this.usersService.create(user));
    })

    await Promise.all(insertPromises);

    return true;
    }

    private async insertVehicles() {

        const vehicles = initialData.vehicles;

        const insertVehicles = [];

        vehicles.forEach(vehicle => {
            insertVehicles.push(this.vehicleRepository.create(vehicle))
        })

        await this.vehicleRepository.save(insertVehicles);
    }
}

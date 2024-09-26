import { BadRequestException, Injectable, InternalServerErrorException, Logger, NotFoundException } from '@nestjs/common';
import { CreateVehicleDto } from './dto/create-vehicle.dto';
import { UpdateVehicleDto } from './dto/update-vehicle.dto';
import { Vehicle } from './entities/vehicle.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PaginationDto } from 'src/common/dtos/pagination.dto';

@Injectable()
export class VehiclesService {

  private readonly logger = new Logger('VehiclesService');

  constructor(
    @InjectRepository(Vehicle)
    private readonly vehicleRepository: Repository<Vehicle>,

    // private readonly dataSource: DataSource
  ) { }

  async create(createVehicleDto: CreateVehicleDto): Promise<Vehicle> {
    try {
      const vehicle = this.vehicleRepository.create(createVehicleDto);
      return await this.vehicleRepository.save(vehicle);
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async findAll(paginationDto: PaginationDto) {
    // return `This action returns all vehicles`;
    const { limit = 10, offset = 0, search, sortColumn, sortDirection } = paginationDto;

    const queryBuilder = this.vehicleRepository.createQueryBuilder('vehicle');

    if (search) {
      queryBuilder.where(
        'LOWER(vehicle.brand) LIKE :search OR LOWER(vehicle.model) LIKE :search',
        { search: `%${search.toLowerCase()}%` },
      );
    }

    // Ordenamiento
    if (sortColumn && sortDirection) {
      const direction = sortDirection.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';
      queryBuilder.orderBy(`vehicle.${sortColumn}`, direction);
    }

    queryBuilder.take(limit).skip(offset);

    const [vehicles, total] = await queryBuilder.getManyAndCount();

    return {
      data: vehicles,
      total,
    };

  }

  async findOne(id: string) {
    const vehicle = await this.vehicleRepository.findOneBy({ id })

    if (!vehicle) {
      throw new NotFoundException(`Vehicle with id "${id}" not found`);
    }

    return vehicle;
  }

  async update(id: string, updateVehicleDto: UpdateVehicleDto) {
    try {
      const vehicle = await this.vehicleRepository.preload({
        id, // Aseguramos que estamos actualizando el objeto con este ID
        ...updateVehicleDto,
      });

      if (!vehicle) {
        throw new NotFoundException(`Torneo con el ID ${id} no encontrado`);
      }

      return this.vehicleRepository.save(vehicle); // Devuelve el objeto actualizado
    } catch (error) {
      this.handleDBExceptions(error);
    }
  }

  async remove(id: string) {
    const vehicle = await this.findOne(id);
    await this.vehicleRepository.remove(vehicle);
  }

  private handleDBExceptions(error: any) {
    if (error.code === '23505')
      throw new BadRequestException(error.detail);

    this.logger.error(error)
    throw new InternalServerErrorException('Unexpected error, check server logs');
  }
}

import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('vehicles')
export class Vehicle {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  brand: string;

  @Column()
  model: string;

  @Column('int')
  year: number;

  @Column('float')
  price: number;

  @Column()
  type: string;
}

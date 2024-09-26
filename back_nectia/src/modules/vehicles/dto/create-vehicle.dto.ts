import { IsNotEmpty, IsNumber, IsOptional, IsPositive, IsString } from "class-validator"

export class CreateVehicleDto {
    @IsString()
    @IsNotEmpty({ message: 'Brand is required' })
    brand: string;

    @IsString()
    @IsNotEmpty({ message: 'Model is required' })
    model: string;

    @IsNumber()
    @IsPositive({ message: "The year does not have a positive value" })
    @IsNotEmpty({ message: 'Year is required' })
    year: number;

    @IsNumber()
    @IsPositive({ message: "The price does not have a positive value" })
    @IsNotEmpty({ message: 'Price is required' })
    price: number;

    @IsString()
    @IsNotEmpty({ message: 'Type is required' })
    type: string;
}

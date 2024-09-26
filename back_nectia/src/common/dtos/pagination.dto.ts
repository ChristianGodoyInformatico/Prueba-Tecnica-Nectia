import { Type } from "class-transformer";
import { IsIn, IsOptional, IsPositive, IsString, Min } from "class-validator";

export class PaginationDto {

    @IsOptional()
    @Type(() => Number) // enableImplicitConversions: true
    limit?: number;

    @IsOptional()
    @Min(0)
    @Type(() => Number) // enableImplicitConversions: true
    offset?: number;

    @IsOptional()
    @IsString()
    search?: string;

    @IsOptional()
    @IsString()
    sortColumn?: string;

    @IsOptional()
    @IsIn(['asc', 'desc'], { message: 'sortDirection must be either "asc" or "desc"' })
    sortDirection?: 'asc' | 'desc';
}
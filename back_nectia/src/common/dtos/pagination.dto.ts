import { Type } from "class-transformer";
import { IsIn, IsOptional, IsString, Min } from "class-validator";

export class PaginationDto {

    @IsOptional()
    @Type(() => Number) 
    limit?: number;

    @IsOptional()
    @Min(0)
    @Type(() => Number)
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
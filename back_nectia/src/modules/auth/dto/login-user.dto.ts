import { IsNotEmpty, IsString, MaxLength, MinLength } from "class-validator";

export class LoginUserDto {
    @IsString()
    @IsNotEmpty({message: "Username is required for Login"})
    username: string;
    
    @IsString()
    @MinLength(6)
    @MaxLength(50)
    @IsNotEmpty({message: "Password is required for Login"})
    password: string;
}

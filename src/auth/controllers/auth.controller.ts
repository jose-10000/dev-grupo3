import { Controller, Post, Req } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { User } from '../models/user.model';
import { Request } from 'express';

@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {
    }
    @Post()
    login(@Req() req: Request) {
        const user = req.user as User
        return this.authService.generateJWT(user);
        
    }
}


import { BeforeInsert, BeforeUpdate, Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('users')
export class User {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column('text', { unique: true })
    username: string;

    @Column('text', { select: false })
    password: string;
    
    @Column({ type: 'text', unique: true })
    email: string;

    @BeforeInsert()
    checkFieldsBeforeInsert() {
        this.username = this.username.toLowerCase().trim();
        this.email = this.email ? this.email.toLowerCase().trim() : null;
    }

    @BeforeUpdate()
    checkFieldsBeforeUpdate() {
        this.checkFieldsBeforeInsert();
    }
}

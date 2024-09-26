interface SeedVehicle {
    brand: string;
    model: string;
    year: number;
    price: number;
    type: string;
}


interface SeedUser {
    username: string;
    password: string;
    email: string;
}

interface SeedData {
    users: SeedUser[];
    vehicles: SeedVehicle[];
}

export const initialData: SeedData = {
    users: [
        {
            username: 'Test One',
            password: 'Abc123',
            email: 'test1@google.com'
        },
        {
            username: 'Test Two',
            email: 'test2@google.com',
            password: 'Abc123'
        },
    ],
    vehicles: [
        {
            brand: 'BMW',
            model: 'A4',
            year: 2002,
            price: 14073.0,
            type: 'SUV'
        },
        {
            brand: 'Mercedes',
            model: 'Mustang',
            year: 2018,
            price: 72938.68,
            type: 'Hatchback'
        },
        {
            brand: 'Audi',
            model: 'Corolla',
            year: 2007,
            price: 17916.13,
            type: 'Hatchback'
        },
        {
            brand: 'Honda',
            model: 'X5',
            year: 2002,
            price: 47198.35,
            type: 'Hatchback'
        },
        {
            brand: 'Tesla',
            model: 'X5',
            year: 2012,
            price: 39291.41,
            type: 'Convertible'
        },
        {
            brand: 'Chevrolet',
            model: 'X5',
            year: 2004,
            price: 32575.95,
            type: 'Sedan'
        },
        {
            brand: 'Ford',
            model: 'Corolla',
            year: 2004,
            price: 36327.86,
            type: 'Hatchback'
        },
        {
            brand: 'Chevrolet',
            model: 'Corolla',
            year: 2015,
            price: 32131.71,
            type: 'Truck'
        },
        {
            brand: 'Mercedes',
            model: 'X5',
            year: 2007,
            price: 25125.71,
            type: 'Minivan'
        },
        {
            brand: 'Toyota',
            model: 'X5',
            year: 2023,
            price: 73453.29,
            type: 'Coupe'
        },
        {
            brand: 'Tesla',
            model: 'Elantra',
            year: 2022,
            price: 20207.96,
            type: 'SUV'
        },
        {
            brand: 'Ford',
            model: 'Model 3',
            year: 2003,
            price: 47248.22,
            type: 'Convertible'
        },
        {
            brand: 'Chevrolet',
            model: 'X5',
            year: 2018,
            price: 18884.6,
            type: 'SUV'
        },
        {
            brand: 'Tesla',
            model: 'Cruze',
            year: 2004,
            price: 52696.95,
            type: 'Truck'
        },
        {
            brand: 'Toyota',
            model: 'Cruze',
            year: 2006,
            price: 31906.67,
            type: 'Sedan'
        },
        {
            brand: 'Hyundai',
            model: 'Corolla',
            year: 2008,
            price: 46612.23,
            type: 'Sedan'
        },
        {
            brand: 'BMW',
            model: 'Cruze',
            year: 2022,
            price: 64148.48,
            type: 'Hatchback'
        },
        {
            brand: 'BMW',
            model: 'Mustang',
            year: 2004,
            price: 11211.69,
            type: 'Convertible'
        },
        {
            brand: 'Tesla',
            model: 'Elantra',
            year: 2012,
            price: 11138.36,
            type: 'Truck'
        },
        {
            brand: 'Tesla',
            model: 'C-Class',
            year: 2018,
            price: 16095.83,
            type: 'Hatchback'
        }
    ],
}
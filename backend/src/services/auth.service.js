require("dotenv").config();

const bcrypt =
    require("bcryptjs");

const jwt =
    require("jsonwebtoken");

const {
    PrismaClient,
} = require(
    "@prisma/client"
);

const prisma =
    new PrismaClient();

class AuthService {

    async register(data) {

        const existingUser =
            await prisma.user.findUnique({

                where: {
                    email: data.email,
                },

            });

        if (existingUser) {

            throw new Error(
                "Email sudah digunakan"
            );

        }

        const hashedPassword =
            await bcrypt.hash(

                data.password,
                10,

            );

        const user =
            await prisma.user.create({

                data: {

                    nama: data.nama,
                    email: data.email,
                    password: hashedPassword,
                    fotoProfil: null,

                },

            });

        return {

            id: user.id,
            nama: user.nama,
            email: user.email,
            fotoProfil: user.fotoProfil,
            role: user.role,
            createdAt: user.createdAt,

        };

    }

    async login(
        email,
        password,
    ) {

        const user =
            await prisma.user.findUnique({

                where: {
                    email,
                },

            });

        if (!user) {

            throw new Error(
                "Email tidak ditemukan"
            );

        }

        const validPassword =
            await bcrypt.compare(

                password,
                user.password,

            );

        if (!validPassword) {

            throw new Error(
                "Password salah"
            );

        }

        const token =
            jwt.sign(

                {

                    id: user.id,
                    role: user.role,

                },

                process.env.JWT_SECRET,

                {

                    expiresIn: "7d",

                },

            );

        return {

            token,

            user: {

                id: user.id,
                nama: user.nama,
                email: user.email,
                role: user.role,
                fotoProfil: user.fotoProfil,

            },

        };

    }
}

module.exports =
    new AuthService();

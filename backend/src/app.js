const express =
    require("express");

const cors =
    require("cors");

const app =
    express();

const authRoute =
    require(
        "./routes/auth.route"
    );

const userRoute =
    require(
        "./routes/user.route"
    );

const jadwalRoute =
    require(
        "./routes/jadwal.route"
    );

const matkulRoute =
    require(
        "./routes/matkul.route"
    );

const tugasRoute =
    require(
        "./routes/tugas.route"
    );

const path =
    require(
        "path"
    );

app.use(cors());

app.use(
    express.json()
);

app.use(
    "/uploads",
    express.static("uploads")
);

app.use(

    "/api/auth",

    authRoute,

);
app.use(

    "/api/user",

    userRoute

);

app.use(

    "/api/jadwal",

    jadwalRoute

);

app.use(
    "/api/matkul",
    matkulRoute,
);

app.use(
    "/api/tugas",
    tugasRoute,
);

app.get(

    "/",

    (req, res) => {

        res.json({

            message: "Backend Jadwalin aktif",

        });

    },

);

app.use(

    "/uploads",

    express.static(

        path.join(

            __dirname,

            "uploads",

        ),

    ),

);

module.exports =
    app;

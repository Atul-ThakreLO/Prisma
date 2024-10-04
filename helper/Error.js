class ErrorHandler extends Error {
    constructor(statusCode, message) {
        super(message);
        this.statusCode = statusCode;
        this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
        this.name = this.constructor.name;
        this.isOprational = true;
        Error.captureStackTrace(this, this.constructor);
    }
}




export const handleError = (err, req, res, next) => {
    const {statusCode, message} = err;

    if(!err.isOprational) {
        return res.status(500).json({
            status: "error",
            message: "Something went wrong"
        })
    }

    res.status(err.statusCode || 500).json({
        status: err.status || "fail",
        message : err.message || "Internal server error"
    })

}

export default ErrorHandler;
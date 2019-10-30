const INTERNAL_SERVER_ERROR_STATUS_CODE = 500;

export class ServiceError extends Error {
    private statusCode: number;

    constructor(message: string, statusCode: number = INTERNAL_SERVER_ERROR_STATUS_CODE) {
        super(message);
        this.statusCode = statusCode;
    }
}

declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: "development" | "production";
      PORT?: string;
      MONGO_URI: string;
      DB_NAME: string;
      COLLECTION_NAME_VOTE: string;
      COLLECTION_NAME_CANDIDATE: string;
      COLLECTION_NAME_PARTY: string;
    }
  }
}

export {};

/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'standalone',
    distDir: process.env.BUILD_DIR || '.next',
};

export default nextConfig;

package app.narvi.pwdhash;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

import org.bouncycastle.crypto.generators.BCrypt;
import org.bouncycastle.util.encoders.Hex;

public class GenPwdHash {
    public static void main( String[] args ) {
        String pwd = args[0];
        byte[] salt = generatePasswordSalt();
        String passwordHash = hashPassword(pwd, salt);
        System.out.println("Password: " + pwd);
        System.out.println("Hash: " + passwordHash);
        System.out.println("Salt in hex: " + Hex.toHexString(salt));
        System.out.println("Salt: " + Base64.getEncoder().encodeToString(salt));
    }

    private static byte[] generatePasswordSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return salt;
    }

    private static String hashPassword(String password, byte[] salt) {
        byte[] hash = BCrypt.generate(password.getBytes(StandardCharsets.UTF_8), salt, 8);
        return Base64.getEncoder().encodeToString(hash);
    }

}

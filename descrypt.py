# Mensaje cifrado en hexadecimal
hex_data = "2D96F131254751DD6C1317320751DD202502876E27925F7313170201DD73206C2501312791DD28725026F206F6C202C250731DD27964781DD201DD732028E201DD28C13128C201DD732075F31317325064202506C202D96F279287751DD70202796F64202502876C25025F201DD6C206F28775E16E254202506C1DD28C1DD279202C6C2501312791DD28725026F206F6C206F2652546E26F201DD26F6E731DD2796420751DD1316E62"

# Convertir a bytes
cipher_bytes = bytes.fromhex(hex_data)

# Función para probar todas las claves XOR de 1 byte
def xor_decrypt(cipher_bytes):
    results = []
    for key in range(256):
        decrypted = bytes(b ^ key for b in cipher_bytes)
        try:
            decoded = decrypted.decode('utf-8')
            results.append((key, decoded))
        except UnicodeDecodeError:
            continue  # Ignora si no es texto válido
    return results

# Ejecutar y filtrar resultados que parezcan español
results = xor_decrypt(cipher_bytes)
for key, text in results:
    if any(word in text for word in ['el', 'que', 'la', 'de', 'los', 'una']):
        print(f"Clave: {key}")
        print(text[:500])  # Muestra solo los primeros 500 caracteres
        print("-" * 50)

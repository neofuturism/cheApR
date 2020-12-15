import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;
import javax.imageio.ImageWriteParam;
import javax.imageio.stream.MemoryCacheImageOutputStream;
import javax.imageio.IIOImage;
import java.io.ByteArrayOutputStream;
import java.io.ByteArrayInputStream;

public class JPGEncoder {

  byte[] encode(PImage img, float compression) throws IOException {
    
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ImageWriter writer = ImageIO.getImageWritersByFormatName("JPG").next();
    ImageWriteParam param = writer.getDefaultWriteParam();
    param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
    param.setCompressionQuality(compression);

    // ImageIO.write((BufferedImage) img.getNative(), "jpg", baos);
    writer.setOutput(new MemoryCacheImageOutputStream(baos));

    writer.write(null, new IIOImage((BufferedImage) img.getNative(), null, null), param);

    return baos.toByteArray();
  }
  

  byte[] encode(PImage img) throws IOException {
    return encode(img,encodingValue);
  }

  PImage decode(byte[] imgbytes) throws IOException, NullPointerException {
    BufferedImage imgbuf = ImageIO.read(new ByteArrayInputStream(imgbytes));
    PImage img = new PImage(imgbuf.getWidth(), imgbuf.getHeight(), ARGB);
    imgbuf.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    img.updatePixels();

    return img;
  }
}

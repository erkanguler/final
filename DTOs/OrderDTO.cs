namespace final.DTO;

public class OrderDTO
{
    public CustomerDTO customer { get; set; } = null!;
    public ICollection<ProductDTO> products { get; set; } = new List<ProductDTO>();

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using final.Models;


namespace final.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderNoLoginProductController : ControllerBase
    {
        private readonly EcommerceContext _context;

        public OrderNoLoginProductController(EcommerceContext context)
        {
            _context = context;
        }

        // GET: api/OrderNoLoginProduct
        [HttpGet]
        public async Task<ActionResult<IEnumerable<OrderNoLoginProduct>>> GetOrderNoLoginProducts()
        {
            return await _context.OrderNoLoginProducts.ToListAsync();
        }

        // GET: api/OrderNoLoginProduct/5
        [HttpGet("{id}")]
        public async Task<ActionResult<OrderNoLoginProduct>> GetOrderNoLoginProduct(int id)
        {
            var orderNoLoginProduct = await _context.OrderNoLoginProducts.FindAsync(id);

            if (orderNoLoginProduct == null)
            {
                return NotFound();
            }

            return orderNoLoginProduct;
        }

        // PUT: api/OrderNoLoginProduct/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrderNoLoginProduct(int id, OrderNoLoginProduct orderNoLoginProduct)
        {
            if (id != orderNoLoginProduct.OrderId)
            {
                return BadRequest();
            }

            _context.Entry(orderNoLoginProduct).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderNoLoginProductExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/OrderNoLoginProduct
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<OrderNoLoginProduct>> PostOrderNoLoginProduct(OrderNoLoginProduct orderNoLoginProduct)
        {
            _context.OrderNoLoginProducts.Add(orderNoLoginProduct);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (OrderNoLoginProductExists(orderNoLoginProduct.OrderId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetOrderNoLoginProduct", new { id = orderNoLoginProduct.OrderId }, orderNoLoginProduct);
        }

        // DELETE: api/OrderNoLoginProduct/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrderNoLoginProduct(int id)
        {
            var orderNoLoginProduct = await _context.OrderNoLoginProducts.FindAsync(id);
            if (orderNoLoginProduct == null)
            {
                return NotFound();
            }

            _context.OrderNoLoginProducts.Remove(orderNoLoginProduct);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool OrderNoLoginProductExists(int id)
        {
            return _context.OrderNoLoginProducts.Any(e => e.OrderId == id);
        }
    }
}

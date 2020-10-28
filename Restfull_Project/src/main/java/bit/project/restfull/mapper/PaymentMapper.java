package bit.project.restfull.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Qualifier;

import bit.project.restfull.vo.PaymentVO;


@Mapper
public interface PaymentMapper {
	
	@Select("select * from goods where destination_name = #{destination_name}")
	public List<PaymentVO> getPayList(String destination_name);
	
	@Select("select * from goods")
	public List<PaymentVO> getPayList2();
}
